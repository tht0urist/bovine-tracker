package io.obouh.bovine.tracker.bovine_tracker.dto

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.NotNull
import java.time.LocalDate

data class EventDto(
    @NotBlank val id: String,
    @NotBlank val value: String,
    @NotNull val date: LocalDate,
    @NotBlank val bovineId: String
)
