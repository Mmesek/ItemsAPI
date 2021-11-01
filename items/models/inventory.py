from typing import List

from models.characters import CharacterID_Mixin, Character
from models.items import InstanceID_Mixin
from models.mixins import Quantity_Mixin
from models.transactions import Transaction

class Inventory(CharacterID_Mixin, InstanceID_Mixin, Quantity_Mixin):
    """
    `Inventory` of a `Character`
    """
    def transfer(self, target: Character, quantity: float):
        """
        Transfers this `Inventory` between `Character`'s
        """
        return

class Items_Mixin:
    """
    Mixin adding List of `Inventory` alongside methods to modify owned items
    """
    items: List[Inventory]
    """List of `Inventory`'ies with `Item` `Instance`s this `Character` own"""
    def add_item(self, item: Inventory) -> Transaction:
        """
        Adds an item to `Character`'s inventory
        """
        return

    def remove_item(self, item: Inventory) -> Transaction:
        """
        Removes an item from `Character`'s inventory
        """
        return
    
    def transfer_item(self, target: 'Character', item: Inventory) -> Transaction:
        """
        Transfers an item between `Character`'s inventories
        """
        return
    
    def claim_item(self) -> Transaction:
        """
        Claim an item for this `Character`'s inventory
        """
        pass

    def gift_item(self) -> Transaction:
        """
        Gift an item from this `Character`'s inventory
        """
        pass

    def exchange_item(self) -> Transaction: # Redunant with transfer?
        """
        Exchange an item between two `Character` inventories
        """
        pass

    def buy_item(self) -> Transaction:
        """
        Buy an item if Character enough of another item
        """
        pass
    
    def sell_item(self) -> Transaction:
        """
        Sell an item for specified price
        """
        pass
