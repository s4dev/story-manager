package std.board

import std.defect.*


class Story {

    String statement
    BoardState state //backlog, dev, test, complete, etc.
    Priority priority
    FunctionalArea functionalArea
    String topic
    Story epic
    Integer phase
    Integer build
    User assignedTo
    Boolean cancelled = false
    Boolean blocked = false
    Date targetDate

    static belongsTo = [FunctionalArea, Story, BoardState]

    static hasMany = [detailStories: Story, estimates: Estimate,
               assumptions: Assumption, requirements: Requirement,
               comments: Comment, confirmations: Confirmation, defects: Defect]

    static constraints = {
        epic nullable: true
        statement size: 1..1500
        assignedTo nullable: true
        cancelled validator: { val, obj ->
            //if cancelled, the card cannot be blocked
            if (val)
                obj.blocked = false

            return true
        }
        targetDate nullable: true
    }

    static mapping = {
        defects cascade: 'save-update'
        comments sort: 'id'
        assumptions sort: 'id'
        requirements sort: 'id'
        confirmations sort: 'id'
        defects sort: 'id'
        estimates sort: 'id'
        detailStories sort: 'id'
    }

    def isEpicStory() {
        return detailStories?.size() > 0
    }

    def hasOpenDefects() {
        Defect.countByStoryAndStateInList(this,
            BoardState.list().findAll{it.category != BoardStateCategory.POST_ITERATION})
    }

    def totalHourEstimate() {
        estimates*.calculateAmountByType(EstimateAmountType.HOURS)?.sum() ?: 0
    }

    def totalHourEstimate(type) {
        estimates.findAll{ it.type == type }*.calculateAmountByType(EstimateAmountType.HOURS)?.sum() ?: 0
    }

    def getStoryStatus() {
        def status = []
        if (this.blocked)
            status << StoryStatus.BLOCKED
        if (this.hasOpenDefects())
            status << StoryStatus.DEFECTIVE

        if (this.cancelled)
            status << StoryStatus.CANCELLED
        else if (BoardState.findAllByCategory(BoardStateCategory.POST_ITERATION)?.contains(this.state))
            status << StoryStatus.COMPLETED

        return status
    }

    String toString() {
        "${id}: $functionalArea/$topic ${statement?.substring(0,[statement?.size(), 30].min())} in $build ${estimates?.collect{it}}"
    }

    /* static queries */
    static def retrieveAllBuildNumbers() {
        Story.createCriteria().list() {
            projections {
                property("build")
            }
            order("build")
        }.unique()
    }

    static def listBuilds() {
        Story.createCriteria().list() {
            projections {
                distinct("build")
            }
            order("build")
        }
    }

    static def listPhases() {
        Story.createCriteria().list() {
            projections {
                distinct("phase")
            }
            order("phase")
        }
    }

    static def search(params) {
        Story.createCriteria().list([max:params.max, offset: params.offset]) {
            if (params?.id)
                eq('id', params.long('id'))

            if (params?.epic?.id)
                eq('epic.id', params.long('epic.id'))

            if (params?.functionalArea?.id)
                eq('functionalArea.id', params.long('functionalArea.id'))

            if (params?.phase)
                eq('phase', params.int('phase'))

            if (params?.build)
                eq('build', params.int('build'))
            else if (params.build != null && params?.build == 0)
                eq('build', 0)

            if (params?.topic)
                ilike('topic', "%${params.topic}%")

            if (params?.priority)
                eq('priority', Priority.valueOf(params.priority))

            if (params?.state?.id)
                eq('state.id', params.long('state.id'))

            if (params?.assignedTo?.id)
                eq('assignedTo.id', params.long('assignedTo.id'))

            if (params?.story)
                ilike('statement', "%${params.story}%")

            if (params?.targetDateFrom && params?.targetDateTo) {
                between('targetDate', Date.parse('MM/dd/yyyy',params.targetDateFrom),
                                      Date.parse('MM/dd/yyyy',params.targetDateTo))
            } else if (params?.targetDateFrom && !params?.targetDateTo) {
                ge('targetDate', Date.parse('MM/dd/yyyy',params.targetDateFrom))
            } else if (!params?.targetDateFrom && params?.targetDateTo) {
                le('targetDate', Date.parse('MM/dd/yyyy',params.targetDateTo))
            }

            if (params?.targetDate)
                eq('targetDate', Date.parse('MM/dd/yyyy',params.targetDate))

            if (params?.blocked)
                eq('blocked', true)

            if (params?.notblocked)
                eq('blocked', false)

            if (params?.cancelled)
                eq('cancelled', true)

            if (params?.notcancelled)
                eq('cancelled', false)

            if (params?.comment) {
                comments {
                    ilike('content', "%${params.comment}%")
                }
            }

            if (params?.assumption) {
                assumptions {
                    ilike('statement', "%${params.assumption}%")
                }
            }

            if (params?.confirmation) {
                confirmations {
                    ilike('text', "%${params.confirmation}%")
                }
            }
        }
    }

    static def assignedToSummary(params) {
        Story.createCriteria().list() {
            if (params?.id)
                eq('id', params.long('id'))

            if (params?.epic?.id)
                eq('epic.id', params.long('epic.id'))

            if (params?.functionalArea?.id)
                eq('functionalArea.id', params.long('functionalArea.id'))

            if (params?.phase)
                eq('phase', params.int('phase'))

            if (params?.build)
                eq('build', params.int('build'))

            if (params?.topic)
                ilike('topic', "%${params.topic}%")

            if (params?.priority)
                eq('priority', Priority.valueOf(params.priority))

            if (params?.state?.id)
                eq('state.id', params.long('state.id'))

            if (params?.assignedTo?.id)
                eq('assignedTo.id', params.long('assignedTo.id'))

            if (params?.story)
                ilike('statement', "%${params.story}%")

            if (params?.targetDateFrom && params?.targetDateTo) {
                between('targetDate', Date.parse('MM/dd/yyyy',params.targetDateFrom),
                                      Date.parse('MM/dd/yyyy',params.targetDateTo))
            } else if (params?.targetDateFrom && !params?.targetDateTo) {
                ge('targetDate', Date.parse('MM/dd/yyyy',params.targetDateFrom))
            } else if (!params?.targetDateFrom && params?.targetDateTo) {
                le('targetDate', Date.parse('MM/dd/yyyy',params.targetDateTo))
            }

            if (params?.targetDate)
                eq('targetDate', Date.parse('MM/dd/yyyy',params.targetDate))

            if (params?.blocked)
                eq('blocked', true)

            if (params?.notblocked)
                eq('blocked', false)

            if (params?.cancelled)
                eq('cancelled', true)

            if (params?.notcancelled)
                eq('cancelled', false)

            if (params?.comment) {
                comments {
                    ilike('content', "%${params.comment}%")
                }
            }

            if (params?.assumption) {
                assumptions {
                    ilike('statement', "%${params.assumption}%")
                }
            }

            if (params?.confirmation) {
                confirmations {
                    ilike('text', "%${params.confirmation}%")
                }
            }

        }.groupBy{it.assignedTo}.sort{it.key}
    }

    static def activeStories() {
        def states = BoardState.list().findAll{
                !['Product Backlog','Complete'].contains(it.name)
            }.collect {it.id}

        Story.createCriteria().list() {
            state {
                'in' ('id', states)
            }
        }
    }
}

enum Priority {
    TBD, LOW, MEDIUM, HIGH, CRITICAL
}

enum StoryStatus {
    BLOCKED, CANCELLED, COMPLETED, DEFECTIVE, OPEN
}
