from items.models.mixins import ID_Mixin

from items.models.attributes import Attributes_Mixin
from items.models.skills import Skills_Mixin

class Item(ID_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    Base `Item` Archetype
    """
    def new_instance(self) -> 'Instance':
        """
        Creates specific item `Instance` containing details and attributes
        """
        return Instance(item_id=self.id)

class ItemID_Mixin:
    item_id: Item.id
    """`Item`.`id` this object is based on"""

class Instance(ID_Mixin, ItemID_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    Detailed `Item` `Instance` with attributes
    """

class InstanceID_Mixin:
    instance_id: Instance.id
    """`Instance.id` this `Inventory` is related to"""
    """`Instance.id` being transfered in this `Transaction`"""