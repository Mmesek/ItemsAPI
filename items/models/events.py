from datetime import datetime

from models.mixins import *

from models.attributes import Attributes_Mixin
from models.skills import Skills_Mixin

class Event(ID_Mixin, Name_Mixin, Description_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `Event` details
    """
    start: datetime
    """`start` date of this `Event`"""
    end: datetime
    """`end` date of this `Event`"""

class EventID_Mixin:
    event_id: Event.id
    """`Event`.`id` this object is associated with"""
