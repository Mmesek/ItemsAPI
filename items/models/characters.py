from items.models.mixins import ID_Mixin

from items.models.server import ServerID_Mixin
from items.models.users import UserID_Mixin
from items.models.attributes import Attributes_Mixin
from items.models.skills import Skills_Mixin

class CharacterID_Mixin:
    character_id: int#Character.id
    """`Character`.`id` this `Inventory` comes from"""

from items.models.inventory import Items_Mixin

class Character(ID_Mixin, UserID_Mixin, ServerID_Mixin, Items_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `User`'s `Charaacter` operating within specified `Server`
    """
    def __init__(self, user_id: int = None, server_id: int = None) -> None:
        self.user_id = user_id
        self.server_id = server_id
