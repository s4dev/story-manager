package std.board

import org.springframework.dao.DataIntegrityViolationException

class ConfirmationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [confirmationInstanceList: Confirmation.list(params), confirmationInstanceTotal: Confirmation.count()]
    }

    def create() {
        [confirmationInstance: new Confirmation(params)]
    }

    def save() {
        def confirmationInstance = new Confirmation(params)
        if (!confirmationInstance.save(flush: true)) {
            render(view: "create", model: [confirmationInstance: confirmationInstance])
            return
        }

		flash.message = message(code: 'default.created.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), confirmationInstance.id])
		if (confirmationInstance.story)
            redirect(controller: "story", action: "show", id: confirmationInstance.story?.id)
        else
            redirect(action: "show", id: confirmationInstance.id)
    }

    def show() {
        def confirmationInstance = Confirmation.get(params.id)
        if (!confirmationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
            redirect(action: "list")
            return
        }

        [confirmationInstance: confirmationInstance]
    }

    def edit() {
        def confirmationInstance = Confirmation.get(params.id)
        if (!confirmationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
            redirect(action: "list")
            return
        }

        [confirmationInstance: confirmationInstance]
    }

    def update() {
        def confirmationInstance = Confirmation.get(params.id)
        if (!confirmationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (confirmationInstance.version > version) {
                confirmationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'confirmation.label', default: 'Confirmation')] as Object[],
                          "Another user has updated this Confirmation while you were editing")
                render(view: "edit", model: [confirmationInstance: confirmationInstance])
                return
            }
        }

        confirmationInstance.properties = params

        if (!confirmationInstance.save(flush: true)) {
            render(view: "edit", model: [confirmationInstance: confirmationInstance])
            return
        }

		flash.message = message(code: 'default.updated.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), confirmationInstance.id])
		if (confirmationInstance.story)
            redirect(controller: "story", action: "show", id: confirmationInstance.story?.id)
        else
            redirect(action: "show", id: confirmationInstance.id)
    }

    def delete() {
        def confirmationInstance = Confirmation.get(params.id)
        def storyId = confirmationInstance?.story?.id
        if (!confirmationInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
            redirect(action: "list")
            return
        }

        try {
            confirmationInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
    		if (storyId)
                redirect(controller: "story", action: "show", id: storyId)
            else
                redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'confirmation.label', default: 'Confirmation'), params.id])
            redirect(action: "show", id: params.id)
        }
    }
}
