Nuestra app
===

Facturas: sistema de creación y administración de comprobantes fiscales.



Creación del proyecto
===

<pre><code data-trim>
#verifica que estés usando jruby
ruby -v
rails new facturas
cd facturas
bundle install
</code></pre>



Configuramos para que siempre use jruby
===

<pre><code data-trim>
#Modificar archivo Gemfile

source 'https://rubygems.org'

ruby '1.9.3', :engine => 'jruby', :engine_version => '1.7.6'
</code></pre>

Note:
- Importante para que todos los developers usen la misma versión.
- Importante para que el servidor de deployment sepa que versión usar.



Scaffolding
===

![Scaffolding](img/scaffolding.jpg)



Un comando
===

<pre><code data-trim>
rails generate scaffold Receipt rfc_emisor:string rfc_receptor:string 
concept:string ammount:decimal tax:decimal total:decimal
#actualizamos la base de datos
rake db:migrate
#iniciamos el server
rails server
</code></pre>

http://localhost:3000/receipts



¿Qué hacer cuando no necesitamos un ABC?
===

Caso de uso: Reporte de comprobantes por RFC receptor



1: Creamos un controlador
====

<pre><code data-trim>
rails generate controller report
</code></pre>



2: Creamos un action
====

<pre><code data-trim>
#archivo app/controllers/report_controller.rb
	
class ReportController < ApplicationController

	def receptor
		receptor = params['receptor']
		puts "receptor => #{receptor}"
	end
	
end
</code></pre>