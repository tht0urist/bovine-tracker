package io.obouh.bovine.tracker.bovine_tracker.api

import io.obouh.bovine.tracker.bovine_tracker.dto.EventDto
import io.obouh.bovine.tracker.bovine_tracker.service.EventSynchronizer
import jakarta.validation.Valid
import jakarta.validation.constraints.NotBlank
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/events")
class EventApi(val eventSynchronizer: EventSynchronizer) {

    @PostMapping("/sync")
    fun syncEvents(
        @RequestHeader @NotBlank deviceId: String,
        @RequestBody @Valid events: List<EventDto>
    ) = eventSynchronizer.syncEvent(deviceId, events)

}