package io.obouh.bovine.tracker.bovine_tracker.document

import jakarta.validation.constraints.NotBlank
import jakarta.validation.constraints.NotNull
import org.springframework.data.mongodb.core.mapping.Document
import java.time.LocalDate

@Document
data class Event(
    @NotBlank val id: String,
    @NotBlank val type: String,
    @NotBlank val value: String,
    @NotNull val date: LocalDate,
    @NotBlank val bovineId: String,
    @NotBlank val deviceId: String
)

