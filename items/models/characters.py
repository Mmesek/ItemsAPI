from models.mixins import *
from models.server import ServerID_Mixin
from models.users import UserID_Mixin
from models.attributes import Attributes_Mixin
from models.skills import Skills_Mixin
from models.inventory import Items_Mixin

class Character(ID_Mixin, UserID_Mixin, ServerID_Mixin, Items_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `User`'s `Charaacter` operating within specified `Server`
    """
    def __init__(self, user_id: int = None, server_id: int = None) -> None:
        self.user_id = user_id
        self.server_id = server_id

class CharacterID_Mixin:
    character_id: Character.id
    """`Character`.`id` this `Inventory` comes from"""