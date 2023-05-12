package team.marela.dragonhack.backend.api.models.events;

import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventCreateDto {
    @NotBlank
    String eventName;
    String description;
    @NotBlank
    String location;
    @NotBlank
    String trr;
    @NotBlank
    String image;
    @NotBlank
    String cardImage;
    @NotBlank
    String workerUsername;
    @NotNull
    List<EventDatesDto> dates;
}
