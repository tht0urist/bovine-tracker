package io.obouh.bovine.tracker.bovine_tracker.api

import io.obouh.bovine.tracker.bovine_tracker.dto.EventDto
import jakarta.validation.Valid
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/events")
class EventApi {

    @PostMapping("/sync")
    fun syncEvents(@RequestBody @Valid events: List<EventDto>) {

    }
}