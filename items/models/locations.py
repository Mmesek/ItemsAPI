from items.models.mixins import ID_Mixin, Name_Mixin, Description_Mixin, Cooldown_Mixin

from items.models.attributes import Attributes_Mixin
from items.models.skills import Skills_Mixin
from items.models.events import EventID_Mixin

class LocationID_Mixin:
    location_id: int#Location.id
    """`Location`.`id` this object is associated with"""


from items.models.drops import Drops_Mixin

class Location(ID_Mixin, Name_Mixin, Description_Mixin, EventID_Mixin, Cooldown_Mixin, Drops_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `Location` details
    """
    level: int
    """Suggested `Level` for this `Location`"""
    difficulty: int
    """`Difficulty` of this `Location`"""

