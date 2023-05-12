package team.marela.dragonhack.backend.services.events;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import team.marela.dragonhack.backend.api.models.events.EventCreateDto;
import team.marela.dragonhack.backend.api.models.events.EventDatesDto;
import team.marela.dragonhack.backend.api.models.events.EventDto;
import team.marela.dragonhack.backend.database.entities.cards.CardTemplateEntity;
import team.marela.dragonhack.backend.database.entities.events.EventDayEntity;
import team.marela.dragonhack.backend.database.entities.events.EventEntity;
import team.marela.dragonhack.backend.database.repositories.cards.CardTemplateRepository;
import team.marela.dragonhack.backend.database.repositories.events.EventDayRepository;
import team.marela.dragonhack.backend.database.repositories.events.EventRepository;
import team.marela.dragonhack.backend.database.repositories.organization.OrganizationRepository;
import team.marela.dragonhack.backend.database.repositories.organization.WorkerRepository;
import team.marela.dragonhack.backend.exceptions.DataNotFoundException;

import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EventServices {

    private final WorkerRepository workerRepository;

    private final EventRepository eventRepository;
    private final EventDayRepository eventDayRepository;
    private final CardTemplateRepository cardTemplateRepository;

    public EventEntity createEvent(EventCreateDto dto) throws DataNotFoundException {
        var worker = workerRepository.findByUsername(dto.getWorkerUsername())
                .orElseThrow(() -> new DataNotFoundException("Worker was not found"));

        var event = EventEntity.builder()
                .eventName(dto.getEventName())
                .location(dto.getLocation())
                .trr(dto.getTrr())
                .image(dto.getImage())
                .organization(worker.getOrganization())
                .build();

        var savedEvent = eventRepository.save(event);

        event.setEventDays(
                new HashSet<>(eventDayRepository.saveAll(
                        dto.getDates().stream()
                                .map(e -> EventDayEntity.builder()
                                        .eventStart(e.getEventStart())
                                        .eventEnd(e.getEventEnd())
                                        .event(savedEvent)
                                        .build()
                                )
                                .toList()
                ))
        );

        var cardTemplate = cardTemplateRepository.save(
                CardTemplateEntity.builder()
                        .image(dto.getImage())
                        .event(savedEvent)
                        .build()
        );

        event.setCardTemplate(cardTemplate);

        return event;
    }

    public List<EventDto> getAllEvents() {
        return mapEntitiesToDto(eventRepository.findAll());
    }

    public List<EventDto> getOrganizationEvents(String workerUsername) throws DataNotFoundException {
        var worker = workerRepository.findByUsername(workerUsername)
                .orElseThrow(() -> new DataNotFoundException("Worker not found"));
        var organization = worker.getOrganization();
        return mapEntitiesToDto(eventRepository.findAllByOrganization(organization));
    }

    private List<EventDto> mapEntitiesToDto(List<EventEntity> entities) {
        return entities.stream()
                .map(e ->
                        EventDto.builder()
                                .eventId(e.getEventId())
                                .eventName(e.getEventName())
                                .image(e.getImage())
                                .location(e.getLocation())
                                .startDate(
                                        e.getEventDays().stream()
                                                .map(EventDayEntity::getEventStart)
                                                .min(LocalDateTime::compareTo)
                                                .get()
                                )
                                .endDate(
                                        e.getEventDays().stream()
                                                .map(EventDayEntity::getEventEnd)
                                                .max(LocalDateTime::compareTo)
                                                .get()
                                )
                                .eventDates(
                                        e.getEventDays().stream()
                                                .map(date -> EventDatesDto.builder()
                                                        .eventStart(date.getEventStart())
                                                        .eventEnd(date.getEventEnd())
                                                        .build()
                                                ).toList()
                                )
                                .build()
                )
                .filter(e -> LocalDateTime.now().isAfter(e.getEndDate()))
                .sorted(Comparator.comparing(EventDto::getStartDate))
                .toList();
    }
}
