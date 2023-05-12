package team.marela.dragonhack.backend.database.entities.events;

import lombok.*;
import team.marela.dragonhack.backend.database.entities.cards.CardEntity;
import team.marela.dragonhack.backend.database.entities.cards.CardTemplateEntity;
import team.marela.dragonhack.backend.database.entities.events.price_menu.PriceItemEntity;
import team.marela.dragonhack.backend.database.entities.organization.OrganizationEntity;
import team.marela.dragonhack.backend.database.entities.organization.WorkerEntity;

import javax.persistence.*;
import java.util.Set;

@Entity(name = "event")
@Table
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class EventEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer eventId;

    @Column(nullable = false, unique = true)
    private String eventName;

    @Column(nullable = false)
    private String location;

    @Column(nullable = false)
    private String trr;

    @Lob
    private String image;

    @OneToMany(mappedBy = "event")
    private Set<EventDayEntity> eventDays;

    @ManyToOne
    @JoinColumn(name = "organization_id")
    private OrganizationEntity organization;

    @ManyToMany
    @JoinTable(
            name = "event_workers",
            joinColumns = {@JoinColumn(name = "worker_id")},
            inverseJoinColumns = {@JoinColumn(name = "event_id")}
    )
    private Set<WorkerEntity> workers;

    @OneToMany(mappedBy = "event")
    private Set<PriceItemEntity> priceMenu;

    @OneToOne(mappedBy = "event")
    private CardTemplateEntity cardTemplate;

    @OneToMany(mappedBy = "event")
    private Set<CardEntity> cards;
}
