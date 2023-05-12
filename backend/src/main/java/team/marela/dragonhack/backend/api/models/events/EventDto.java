package team.marela.dragonhack.backend.api.models.events;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventDto {
    Integer eventId;
    String eventName;
    String location;
    String image;
    LocalDateTime startDate;
    LocalDateTime endDate;
    List<EventDatesDto> eventDates;
}
