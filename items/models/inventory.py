from __future__ import annotations

from typing import List, Union, TYPE_CHECKING

#from models.characters import CharacterID_Mixin
class CharacterID_Mixin:
    pass

from items.models.mixins import Quantity_Mixin
from items.models.items import InstanceID_Mixin

from items.exceptions import NotEnoughItems

if TYPE_CHECKING:
    from items.models.transactions import Transaction
    from items.models.characters import Character

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
    def add_item(self, *items: Inventory, transaction: Transaction = None) -> Union[Transaction, None]:
        """
        Adds an item to `Character`'s inventory
            Adds `receive` `TransactionInventory` to `Transaction`
        Returns `Transaction`
        """
        _existing = False
        for item in items:
            if transaction:
                transaction.receive(self.character_id, item.instance_id, item.quantity)
            for owned_item in self.items:
                if owned_item.instance_id == item.instance_id:
                    owned_item.quantity += item.quantity
                    _existing = True
                    break
            if not _existing:
                self.items.append(item)
        return transaction

    def remove_item(self, *items: Inventory, transaction: Transaction = None, force_remove: bool = False) -> Union[Transaction, None]:
        """
        Removes an item from `Character`'s inventory. 
            Adds `send` `TransactionInventory` to `Transaction`
        Returns `Transaction`
        Throws `NotEnoughItems` when there is not enough items to remove on user unless `force_remove` is set to `True`
        """
        for item in items:
            if transaction:
                transaction.send(self.character_id, item.instance_id, item.quantity)
            for owned_item in self.items:
                if owned_item.instance_id == item.instance_id:
                    if not force_remove and owned_item.quantity < item.quantity:
                        raise NotEnoughItems(owned_item, item)
                    owned_item.quantity -= item.quantity
                    if owned_item.quantity == 0:
                        self.items.remove(owned_item)
                    break
        return transaction
    
    def transfer_item(self, recipent: 'Character', 
                sent: List[Inventory], received: List[Inventory], 
                server_id: int = None, transaction: Transaction = None,
                remove_recipent_item: bool = True, remove_own_item: bool = False
        ) -> Transaction:
        """
        Transfers an item between `Character`'s inventories
        
        Params
        ------
        `recipent`:
            `Character` which receives `sent` inventories and send `received` inventories
        `server_id`:
            ID of Server on which transfer is happening to create transaction automatically
        `sent`:
            Inventory objects containing item that should be removed from current user and added to remote user
        `received`:
            Inventory objects containing item that should be added to current user and removed from remote user
        `remove_recipent_item`: 
            Whether it should remove item from recieving `Character` 
            (Sent removed from current user and/or Received removed from another user, useful for exchanges)
        `remove_own_item`:
            Whether it should remove received item from current `Character`
            (Useful when turning item from one to another on same user)
        """
        if not transaction:
            transaction = Transaction(server_id = server_id)
        if sent:
            recipent.add_item(*sent, transaction=transaction)
            if remove_recipent_item and not remove_own_item:
                self.remove_item(*sent, transaction)
        if received:
            if not remove_own_item:
                self.add_item(*received, transaction=transaction)
            else:
                self.remove_item(*received, transaction=transaction)
            if remove_recipent_item and not remove_own_item:
                recipent.remove_item(*received, transaction=transaction)
        return transaction
    
    def claim_item(self, *items: Inventory, server_id: int = None, transaction: Transaction = None) -> Transaction:
        """
        Claim an item for this `Character`'s inventory
        """
        return self.transfer_item(recipent = None, received = items, server_id = server_id, transaction = transaction, remove_recipent_item = False)

    def gift_item(self, recipent: 'Character', *items: Inventory, server_id: int = None, transaction: Transaction = None) -> Transaction:
        """
        Gift an item from this `Character`'s inventory
        """
        return self.transfer_item(recipent = recipent, sent = items, server_id = server_id, transaction = transaction)

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
