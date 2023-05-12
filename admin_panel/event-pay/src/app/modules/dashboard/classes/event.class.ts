
interface IEvent {
    eventId?: number,
    eventName?: string;
    description?: string;
    location?: string;
    startDate?: Date;
    endDate?: Date;
    eventDates?: IDates[];
    trr?: string;
    image?: string;
    cardImage?: string;
    workerUsername?: string;
}

export interface IDates {
    eventStart?: Date,
    eventEnd?: Date,
    description?: String
}

export class Event {
    public eventId: number | null = null;
    public eventName: string | null = null;
    public description: string | null = null;
    public location: string | null = null;
    public startDate: Date | null = null;
    public endDate: Date | null = null;
    public eventDates: IDates[] | null = null;
    public trr: string | null = null;
    public image: string | null = null;
    public cardImage: string | null = null;
    public workerUsername: string | null = null;

    constructor(eventShape: IEvent) {
        if (eventShape.eventId != null) {
            this.eventId = eventShape.eventId;
        }
        if (eventShape.eventName != null) {
            this.eventName = eventShape.eventName;
        }
        if (eventShape.description != null) {
            this.description = eventShape.description;
        }
        if (eventShape.location != null) {
            this.location = eventShape.location;
        }
        if (eventShape.startDate != null) {
            this.startDate = eventShape.startDate;
        }
        if (eventShape.endDate != null) {
            this.endDate = eventShape.endDate;
        }
        if (eventShape.eventDates != null) {
            this.eventDates = eventShape.eventDates;
        }
        if (eventShape.trr != null) {
            this.trr = eventShape.trr;
        }
        if (eventShape.image != null) {
            this.image = eventShape.image;
        }
        if (eventShape.cardImage != null) {
            this.cardImage = eventShape.cardImage;
        }
        if (eventShape.workerUsername != null) {
            this.workerUsername = eventShape.workerUsername;
        }
    }
}