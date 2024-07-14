package io.obouh.bovine.tracker.bovine_tracker.repository

import io.obouh.bovine.tracker.bovine_tracker.document.Event
import org.springframework.data.mongodb.repository.MongoRepository
import org.springframework.stereotype.Repository

@Repository
interface EventRepository : MongoRepository<Event, String> {

    fun deleteByDeviceId(deviceId: String): Long
}