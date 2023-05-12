package team.marela.dragonhack.backend.api.admin.events;

import lombok.RequiredArgsConstructor;
import lombok.extern.java.Log;
import org.modelmapper.ModelMapper;
import org.springframework.web.bind.annotation.*;
import team.marela.dragonhack.backend.api.models.events.EventCreateDto;
import team.marela.dragonhack.backend.api.models.events.EventDto;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;
import team.marela.dragonhack.backend.services.events.EventServices;

import javax.validation.Valid;
import java.util.List;

@Log
@RestController
@RequestMapping("/admin/events")
@RequiredArgsConstructor
@CrossOrigin("*")
public class AdminEventsApi {

    private final EventServices eventServices;
    private final ModelMapper modelMapper;

    @GetMapping
    public List<EventDto> getOrganizationEvents(@RequestHeader(value = "WorkerUsername", defaultValue = "janez") String workerUsername) throws DataNotFoundException {
        return eventServices.getOrganizationEvents(workerUsername);
    }

    @PostMapping
    public EventCreateDto createEvent(@Valid @RequestBody EventCreateDto dto) throws DataNotFoundException {
        log.info(dto.toString());
        var event = eventServices.createEvent(dto);
        return modelMapper.map(event, EventCreateDto.class);
    }
}
