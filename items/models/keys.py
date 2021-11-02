from items.models.mixins import ID_Mixin, Name_Mixin

from items.models.items import ItemID_Mixin

class Keys(ID_Mixin, Name_Mixin, ItemID_Mixin):
    """Keys associated with this item"""
    key: str
    """Key for this Item"""