class Aparato {
	var property color = "blanco"
	
	method puedeUsar(unaPersona)
	method serUsado(unaPersona)
	method necesitaMantenimiento()
	method realizarMantenimiento()
}

class Magneto inherits Aparato {
	var imantacion = 800
	
	override method puedeUsar(unaPersona) = true
	override method serUsado(unaPersona){ unaPersona.nivelDeDolor( unaPersona.nivelDeDolor() * 0.9 ) 
											imantacion -= 1
	}
	override method necesitaMantenimiento() = imantacion < 100
	override method realizarMantenimiento(){ if(self.necesitaMantenimiento()){ imantacion += 500 } else self.error("no necesita mantenimiento")}
}
	
class Bicicleta inherits Aparato {
	var vecesTornillosDesajustados = 0
	var vecesQueSePierdeAceite = 0
	
	override method puedeUsar(unaPersona) = unaPersona.edad() > 8
	override method serUsado(unaPersona){ 
		if(unaPersona.nivelDeDolor() > 30){vecesTornillosDesajustados += 1 if(unaPersona.edad().between(30, 50)) { vecesQueSePierdeAceite += 1 } }
		unaPersona.nivelDeDolor( unaPersona.nivelDeDolor() - 4 ) 
		unaPersona.nivelDeFortaleza( unaPersona.nivelDeFortaleza() + 3 )
	}
	override method necesitaMantenimiento() = vecesTornillosDesajustados > 9 or vecesQueSePierdeAceite > 4
	override method realizarMantenimiento(){ if(self.necesitaMantenimiento()){ vecesTornillosDesajustados = 0  vecesQueSePierdeAceite = 0} else self.error("no necesita mantenimiento")}
}

class Minitramp inherits Aparato {
	override method puedeUsar(unaPersona) = unaPersona.nivelDeDolor() < 20
	override method serUsado(unaPersona){ unaPersona.nivelDeFortaleza( unaPersona.nivelDeFortaleza() + unaPersona.edad() * 0.1 ) }
	override method necesitaMantenimiento() = null
	override method realizarMantenimiento(){ }
}

object centro{
	const aparatos = []
	const pacientes = []
	
	method agregarAparato(unAparato){ aparatos.add(unAparato) }
	method coloresDeLosAparatos() = aparatos.map({ aparato => aparato.color() }).asSet()
	method pacientesMenoresDe8() = pacientes.filter({ paciente => paciente.edad() < 8 })
	method cantidadPacientesQueNoPuedenCumplirSesion() = pacientes.count({ paciente => not paciente.puedeRealizarRutina() })
	method estaEnOptimasCondiciones() = aparatos.all({ aparato => not aparato.necesitaMantenimiento() })
	method estaComplicado() = aparatos.count({ aparato => aparato.necesitaMantenimiento() }) >= aparatos.size()/2
	method visitaTecnica(){ aparatos.forEach({ aparato => aparato.realizarMantenimiento() }) }
}