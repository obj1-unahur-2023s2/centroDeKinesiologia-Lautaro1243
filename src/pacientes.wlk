import aparatos.*

class Paciente {
	const edad
	var property nivelDeFortaleza
	var property nivelDeDolor
	const rutina = []
	
	method edad() = edad
	method usarAparato(unAparato){ if(unAparato.puedeUsar(self)){ unAparato.serUsado(self) } else self.error("el aparato no puede ser usado por la persona")}
	method agregarARutina(aparato){ rutina.add(aparato) }
	method puedeRealizarRutina() = rutina.all({aparato => aparato.puedeUsar(self)})
	method realizarRutina(){ if(self.puedeRealizarRutina()){ rutina.forEach({ aparato => aparato.serUsado(self) }) } else self.error("no puede realizar la rutina asignada")}
}

class PacienteResistente inherits Paciente {
	override method realizarRutina() {  super()
										self.nivelDeFortaleza(self.nivelDeFortaleza() + rutina.size())
										
	}
}


class PacienteCaprichoso inherits Paciente {
	override method puedeRealizarRutina() = super() and rutina.any({aparato => aparato.color() == "rojo"})
	override method realizarRutina() { super() super() }
}


class PacienteRapidaRecuperacion inherits Paciente {
	override method realizarRutina() { super() self.nivelDeDolor(self.nivelDeDolor() - valorDeRecuperacion.valorDeRecuperacion()) }
}


object valorDeRecuperacion {
	var property valorDeRecuperacion = 3
}