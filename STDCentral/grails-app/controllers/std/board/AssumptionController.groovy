package std.board

import org.springframework.dao.DataIntegrityViolationException

class AssumptionController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [assumptionInstanceList: Assumption.list(params), assumptionInstanceTotal: Assumption.count()]
    }

    def create() {
        [assumptionInstance: new Assumption(params)]
    }

    def save() {
        def assumptionInstance = new Assumption(params)
        if (!assumptionInstance.save(flush: true)) {
            render(view: "create", model: [assumptionInstance: assumptionInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'assumption.label', default: 'Assumption'), assumptionInstance.id])
		if (assumptionInstance.story)
            redirect(controller: "story", action: "show", id: assumptionInstance.story?.id)
        else
            redirect(action: "show", id: assumptionInstance.id)
    }

    def show() {
        def assumptionInstance = Assumption.get(params.id)
        if (!assumptionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
            redirect(action: "list")
            return
        }

        [assumptionInstance: assumptionInstance]
    }

    def edit() {
        def assumptionInstance = Assumption.get(params.id)
        if (!assumptionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
            redirect(action: "list")
            return
        }

        [assumptionInstance: assumptionInstance]
    }

    def update() {
        def assumptionInstance = Assumption.get(params.id)
        if (!assumptionInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (assumptionInstance.version > version) {
                assumptionInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'assumption.label', default: 'Assumption')] as Object[],
                          "Another user has updated this Assumption while you were editing")
                render(view: "edit", model: [assumptionInstance: assumptionInstance])
                return
            }
        }

        assumptionInstance.properties = params

        if (!assumptionInstance.save(flush: true)) {
            render(view: "edit", model: [assumptionInstance: assumptionInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'assumption.label', default: 'Assumption'), assumptionInstance.id])
		if (assumptionInstance.story)
            redirect(controller: "story", action: "show", id: assumptionInstance.story?.id)
        else
            redirect(action: "show", id: assumptionInstance.id)
    }

    def delete() {
        def assumptionInstance = Assumption.get(params.id)
        def storyId = assumptionInstance?.story?.id
        if (!assumptionInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
            redirect(action: "list")
            return
        }

        try {
            assumptionInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
			if (storyId)
			    redirect(controller: "story", action: "show", id: storyId)
            else
                redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'assumption.label', default: 'Assumption'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
