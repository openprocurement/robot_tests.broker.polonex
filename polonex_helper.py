# -*- coding: utf-8 -*-
import dateutil.parser
from datetime import datetime
from pytz import timezone
import os


def polonex_convertdate(isodate):
    date = dateutil.parser.parse(isodate)
    return date.strftime("%Y-%m-%d %H:%M")

def convert_date_polonex(isodate):
    date = datetime.strptime(isodate, "%d-%m-%Y\n%H:%M")
    res = date.strftime("%Y-%m-%d %H:%M:%S.%f")
    return res

def add_timezone_to_date(date_str):
    new_date = datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S")
    TZ = timezone(os.environ['TZ'] if 'TZ' in os.environ else 'Europe/Kiev')
    new_date_timezone = TZ.localize(new_date)
    return new_date_timezone.strftime("%Y-%m-%d %H:%M:%S%z")

def convert_polonex_date_to_iso_format(date_time_from_ui):
    new_timedata = datetime.strptime(date_time_from_ui, '%d-%m-%Y\n%H:%M')
    new_date_time_string = new_timedata.strftime("%Y-%m-%d %H:%M:%S.%f")
    return new_date_time_string

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

