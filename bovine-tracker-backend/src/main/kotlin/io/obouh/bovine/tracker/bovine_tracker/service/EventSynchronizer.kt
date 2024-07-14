package io.obouh.bovine.tracker.bovine_tracker.service

import io.obouh.bovine.tracker.bovine_tracker.dto.EventDto
import io.obouh.bovine.tracker.bovine_tracker.dto.toEvent
import io.obouh.bovine.tracker.bovine_tracker.repository.EventRepository
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional

@Component
@Transactional
class EventSynchronizer(private val eventRepository: EventRepository) {

    /**
     * Synchronizes a list of event data transfer objects (DTOs) with the database.
     *
     * This method performs the following steps:
     * <ol>
     *     <li>Deletes all existing events from the database related to deviceId.</li>
     *     <li>Maps the payload (list of EventDto objects) to document entities.</li>
     *     <li>Stores the mapped document entities into the database.</li>
     * </ol>
     *
     * @param deviceId the unique identifier of the mobile device
     * @param events the list of EventDto objects to be synchronized with the database
     */
    fun syncEvent(deviceId: String, events: List<EventDto>) {
        // delete all the events
        eventRepository.deleteByDeviceId(deviceId)

        // map payload to documents
        val eventDocuments = events.stream().map { it.toEvent() }.toList()

        // store documents
        eventRepository.saveAll(eventDocuments)
    }
}