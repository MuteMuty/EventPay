package team.marela.dragonhack.backend.api.models.events;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventDatesDto {
    LocalDateTime eventStart;
    LocalDateTime eventEnd;
}
