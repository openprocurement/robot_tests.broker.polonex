# -*- coding: utf-8 -*-
import dateutil.parser
from datetime import datetime


def polonex_convertdate(isodate):
    date = dateutil.parser.parse(isodate)
    return date.strftime("%Y-%m-%d %H:%M")

def convert_date_polonex(isodate):
    return datetime.strptime(isodate, "%Y-%m-%d %H:%M").isoformat()

def convert_polonex_string(string):
    return {
            u"Так": True,
            u"Hi": False,
            'active.enquiries': u'Період уточнень',
            'active.tendering': u'Очікування пропозицій',
            'active.auction': u'Період аукціону',
            'active.qualification': u'Кваліфікація переможця',
            'active.awarded': u'Пропозиції розглянуто',
            'unsuccessful': u'Закупівля не відбулась',
            'complete': u'Завершена закупівля',
            'cancelled': u'Відмінена закупівля',
            }.get(string, string)
