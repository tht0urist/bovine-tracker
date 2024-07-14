package io.obouh.bovine.tracker.bovine_tracker.dto

import io.obouh.bovine.tracker.bovine_tracker.document.Event
import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.NotNull
import java.time.LocalDate

data class EventDto(
    @NotBlank val id: String,
    @NotBlank val type: String,
    @NotBlank val value: String,
    @NotNull val date: LocalDate,
    @NotBlank val bovineId: String,
    @NotBlank val deviceId: String
)
fun EventDto.toEvent(): Event {
    return Event(
        id = this.id,
        type = this.type,
        value = this.value,
        date = this.date,
        bovineId = this.bovineId,
        deviceId = this.deviceId
    )
}