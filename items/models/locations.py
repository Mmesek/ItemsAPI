from models.mixins import *

from models.attributes import Attributes_Mixin
from models.skills import Skills_Mixin
from models.events import EventID_Mixin
from models.drops import Drops_Mixin

class Location(ID_Mixin, Name_Mixin, Description_Mixin, EventID_Mixin, Cooldown_Mixin, Drops_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `Location` details
    """
    level: int
    """Suggested `Level` for this `Location`"""
    difficulty: int
    """`Difficulty` of this `Location`"""

class LocationID_Mixin:
    location_id: Location.id
    """`Location`.`id` this object is associated with"""
