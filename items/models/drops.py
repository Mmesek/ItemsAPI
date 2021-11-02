from typing import List

from items.models.attributes import Attributes_Mixin
from items.models.skills import Skills_Mixin
from items.models.locations import LocationID_Mixin
from items.models.items import ItemID_Mixin, Item
from items.models.events import EventID_Mixin, Event

class Drop(LocationID_Mixin, ItemID_Mixin, EventID_Mixin, Attributes_Mixin, Skills_Mixin):
    """
    `Drop` for an `Item` in a `Location` during `Event` settings
    """
    weight: float
    """`Weight` of this `Drop` compared to others"""
    chance: float
    """`Chance` for this `Drop`"""
    region_limit: float
    """Limit of this `Drop`s within associated `Location`"""
    quantity_min: float
    """Minimal quantity to drop"""
    quantity_max: float
    """Maximal quantity to drop"""

class Drops_Mixin:
    """
    Mixin adding List of `Drop`s alongside methods to modify them
    """
    drops: List[Drop]
    """List of `Drop`s associated with this object"""
    def new_drop(self, item: Item, event: Event, weight: float, chance: float, limit: float, min: float, max: float) -> Drop:
        drop = Drop(item_id=item.id, event_id=event.id, weight=weight, chance=chance, region_limit=limit, quantity_min=min, quantity_max=max)
        self.drops.append(drop)
        return drop