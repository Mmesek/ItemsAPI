from typing import TYPE_CHECKING

from items.models.mixins import ID_Mixin

if TYPE_CHECKING:
    from items.models.characters import Character


class User(ID_Mixin):
    """
    `User` Base
    """

    def new_character(self, server=None) -> "Character":
        """
        Create a new `Character` for this `User`
        """
        from items.models.characters import Character

        return Character(user_id=self.id, server_id=server)


class UserID_Mixin:
    user_id: User.id
    """`User`.`id` this object belongs to"""
