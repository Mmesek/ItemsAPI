from typing import List

from items.models.mixins import ID_Mixin, Name_Mixin, Description_Mixin

class Attribute(ID_Mixin, Name_Mixin, Description_Mixin):
    """Associated `Attribute`"""
    value: float
    """`value` of this `Attribute`"""

class Attributes_Mixin:
    attributes: List[Attribute]
    """List of associated `Attribute`s"""
