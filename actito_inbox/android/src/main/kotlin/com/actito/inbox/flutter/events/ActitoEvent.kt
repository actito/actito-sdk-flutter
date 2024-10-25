package com.actito.inbox.flutter.events

import com.actito.inbox.models.ActitoInboxItem
import com.actito.inbox.models.toJson
import java.util.*

internal sealed class ActitoEvent {

    abstract val type: Type
    abstract val payload: Any?

    enum class Type(val id: String) {
        INBOX_UPDATED(id = "inbox_updated"),
        BADGE_UPDATED(id = "badge_updated"),
    }

    class InboxUpdated(
        items: SortedSet<ActitoInboxItem>
    ) : ActitoEvent() {
        override val type = Type.INBOX_UPDATED
        override val payload = items.map { it.toJson() }
    }

    class BadgeUpdated(
        badge: Int
    ) : ActitoEvent() {
        override val type = Type.BADGE_UPDATED
        override val payload = badge
    }
}
