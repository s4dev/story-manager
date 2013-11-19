package std.board

import org.springframework.dao.DataIntegrityViolationException

class RequirementController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [requirementInstanceList: Requirement.list(params), requirementInstanceTotal: Requirement.count()]
    }

    def create() {
        [requirementInstance: new Requirement(params)]
    }

    def save() {
        def requirementInstance = new Requirement(params)
        if (!requirementInstance.save(flush: true)) {
            render(view: "create", model: [requirementInstance: requirementInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'requirement.label', default: 'Requirement'), requirementInstance.id])

        if (requirementInstance?.story)
            redirect(controller: "story", action: "show", id: requirementInstance?.story?.id)
        else
            redirect(action: "show", id: requirementInstance.id)
    }

    def show() {
        def requirementInstance = Requirement.get(params.id)
        if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            redirect(action: "list")
            return
        }

        [requirementInstance: requirementInstance]
    }

    def edit() {
        def requirementInstance = Requirement.get(params.id)
        if (!requirementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            redirect(action: "list")
            return
        }

        [requirementInstance: requirementInstance]
    }

    def update() {
        def requirementInstance = Requirement.get(params.id)
        if (!requirementInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (requirementInstance.version > version) {
                requirementInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'requirement.label', default: 'Requirement')] as Object[],
                          "Another user has updated this Requirement while you were editing")
                render(view: "edit", model: [requirementInstance: requirementInstance])
                return
            }
        }

        requirementInstance.properties = params

        if (!requirementInstance.save(flush: true)) {
            render(view: "edit", model: [requirementInstance: requirementInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'requirement.label', default: 'Requirement'), requirementInstance.id])

        if (requirementInstance?.story)
            redirect(controller: "story", action: "show", id: requirementInstance?.story?.id)
        else
            redirect(action: "show", id: requirementInstance.id)
    }

    def delete() {
        def requirementInstance = Requirement.get(params.id)
        def storyId = requirementInstance?.story?.id
        if (!requirementInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            redirect(action: "list")
            return
        }

        try {
            requirementInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            if (storyId)
                redirect(controller: "story", action: "show", id: storyId)
            else
                redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'requirement.label', default: 'Requirement'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
