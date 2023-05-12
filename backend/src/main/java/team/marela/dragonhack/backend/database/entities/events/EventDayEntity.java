package team.marela.dragonhack.backend.database.entities.events;

import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity(name = "event_day")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventDayEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer eventDayId;

    @Column(nullable = false)
    private LocalDateTime eventStart;

    @Column(nullable = false)
    private LocalDateTime eventEnd;

    @Lob
    private String description;

    @ManyToOne
    @JoinColumn(name = "event_id")
    private EventEntity event;
}
