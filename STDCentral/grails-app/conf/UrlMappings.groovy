class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/login/$action?"(controller: "login")
		"/logout/$action?"(controller: "logout")

		"/"(controller:"home", action:"index")
        "/help"(view:"/help")
        "/passwordHelp"(view:"/password")

		"500"(view:'/error')
	}
}
