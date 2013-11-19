package std.board

class Estimate {

    static final Integer HOURS_PER_DAY = 6  //TODO: change to configurable amount

    EstimateType type
    Integer amount
    EstimateAmountType amountType
    Story story

    static belongsTo = [Story]

    static constraints = {
        amount min: 0, blank: false
    }


    def calculateAmountByType(type) {
        if (type == EstimateAmountType.HOURS)
            if (amountType == EstimateAmountType.HOURS)
                return amount ?: 0
            else
                return (amount ?: 0)*HOURS_PER_DAY
        else if (type == EstimateAmountType.DAYS)
            if (amountType == EstimateAmountType.HOURS)
                return (amount ?: 0) / HOURS_PER_DAY
            else
                return amount ?: 0
    }

    String toString() {
        "${type}: $amount $amountType"
    }
}

enum EstimateType {
    DEV, TEST, REQ, REWORK

    String toString() {
        super.toString().toLowerCase().capitalize()
    }
}

enum EstimateAmountType {
    HOURS, DAYS

    String toString() {
        super.toString().toLowerCase().capitalize()
    }
}
