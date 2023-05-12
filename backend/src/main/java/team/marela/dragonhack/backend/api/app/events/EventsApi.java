package team.marela.dragonhack.backend.api.app.events;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import team.marela.dragonhack.backend.api.models.events.EventDto;
import team.marela.dragonhack.backend.services.events.EventServices;

import java.util.List;

@RestController
@RequestMapping("/events")
@RequiredArgsConstructor
public class EventsApi {

    private final EventServices eventServices;

    @GetMapping
    public List<EventDto> getAllEvents() {
        return eventServices.getAllEvents();
    }
}
