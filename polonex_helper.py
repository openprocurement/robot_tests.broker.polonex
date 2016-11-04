# -*- coding: utf-8 -*-
import dateutil.parser
from datetime import datetime


def polonex_convertdate(isodate):
    date = dateutil.parser.parse(isodate)
    return date.strftime("%Y-%m-%d %H:%M")

def convert_date_polonex(isodate):
    return datetime.strptime(isodate, "%d-%m-%Y\n%H:%M").isoformat()

def split_descr(str):
    return str.split(' - ')[1];

def convert_polonex_string(string):
    return {
            'True': '1',
            'False': '0',
            u"Так": True,
            u"Hi":  False,
            u'Період уточнень':        'active.enquiries',
            u'Очікування пропозицій':  'active.tendering',
            u'Період аукціону':        'active.auction',
            u'Кваліфікація переможця': 'active.qualification',
            u'Пропозиції розглянуто':  'active.awarded',
            u'Закупівля не відбулась': 'unsuccessful',
            u'Завершена закупівля':    'complete',
            u'Відмінена закупівля':    'cancelled',
            u'Грн.': 'UAH',
            u'(включно з ПДВ)': True,
            u'(без ПДВ)': False,
            }.get(string, string)

