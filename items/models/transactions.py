from typing import List

from items.models.mixins import ID_Mixin, Timestamp_Mixin, Quantity_Mixin

from items.models.server import Server, ServerID_Mixin
from items.models.characters import Character, CharacterID_Mixin
from items.models.items import Instance, InstanceID_Mixin

class Transaction(ID_Mixin, ServerID_Mixin, Timestamp_Mixin):
    """
    `Transaction` of `Item`s between `Character`s
    """
    items: List['Transaction_Inventory']
    """List of related `Transaction_Inventory` with `Item`s `Instance``s being transferred"""
    def __init__(self, server_id: Server.id = None) -> None:
        """
        `server_id`: Server ID where this transaction is happening
        """
        self.server_id = server_id
        self.items = [] # Don't actually do that once ORM is in place, we don't want to overwrite relationship accidently

    def send(self, character_id: Character.id, instance_id: Instance.id, quantity: float = 1) -> 'Transaction_Inventory':
        """
        Character sending and Instance being send with this `Transaction`
        Adds `Transaction_Inventory` to this `Transaction`
        """
        inventory = Transaction_Inventory(character_id=character_id, instance_id=instance_id, quantity=quantity, sent=True)
        self.items.append(inventory)
        return inventory

    def receive(self, character_id: Character.id, instance_id: Instance.id, quantity: float = 1) -> 'Transaction_Inventory':
        """
        Character receiving and Instance being received with this `Transaction`
        Adds `Transaction_Inventory` to this `Transaction`
        """
        inventory = Transaction_Inventory(character_id=character_id, instance_id=instance_id, quantity=quantity, sent=False)
        self.items.append(inventory)
        return inventory

class Transaction_Inventory(CharacterID_Mixin, InstanceID_Mixin, Quantity_Mixin):
    """
    `Transaction`'s Inventory with item `Instance` and quantity being transferred
    """
    transaction_id: Transaction.id
    """`Transaction`.`id` this `Transaction_Inventory` is attached to"""
    sent: bool
    """Whether this Inventory is being `sent` from `User` or received"""
    def __init__(self, character_id: Character.id, instance_id: Instance.id, quantity: float = 1, sent: bool = False) -> None:
        """
        `character_id`: `Character`'s inventory this `Instance` comes from
        `instance_id`: `Instance` being transfered
        `quantity`: Amount being transfered
        `sent`: Whether this is outgoing `Inventory`
        """
        self.character_id = character_id
        self.instance_id = instance_id
        self.quantity = quantity
        self.sent = sent
