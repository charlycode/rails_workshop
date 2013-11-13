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
		@rfc_receptor = params['receptor']		
		puts "receptor => #{@rfc_receptor}"
	end
	
end
</code></pre>



3: Agregamos una nueva ruta
===

<pre><code data-trim>
#archivo config/routes.rb
get "report/receptor"
</code></pre>

http://localhost:3000/report/receptor?receptor=AAA010101AAA



4: Creamos el view
====

<pre><code data-trim>
#archivo app/views/report/receptor.html.erb
<h1>Comprobantes con el RFC receptor: <%= @rfc_receptor %></h1>
<table>
	<thead>
		<tr>
			<th>RFC Emisor</th>
			<th>RFC Receptor</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>
<% @receipts.each do |receipt| %>
		<tr>
			<td><%= receipt['emisor'] %></td>
			<td><%= receipt['receptor'] %></td>
			<td><%= receipt['total'] %></td>
		</tr>
<% end %>
	</tbody>
</table>
</pre></code>




5: Creamos datos de prueba
====

<pre><code data-trim>
class ReportController < ApplicationController

  def receptor
	@rfc_receptor = params['receptor']		
	 puts "receptor => #{@rfc_receptor}"
	 @receipts = [ 
	  { 'emisor' => 'BBB020305RRR','receptor' => @rfc_receptor, 'total' => 1020.45},
	  { 'emisor' => 'TTT090817DEW','receptor' => @rfc_receptor, 'total' => 89000.17},
	  { 'emisor' => 'ZXC070801WWW','receptor' => @rfc_receptor, 'total' => 98211.45}
 	 ]
  end

end
</code></pre>



6: Reload
===

![Tabla](img/facturas01.png)



7: URLs RESTful
===

<pre><code data-trim>
#archivo config/routes.rb
#comentamos la anterior	
#get "report/receptor"
  
get '/report/:receptor', to: 'report#receptor'
</code></pre>

http://localhost:3000/report/AAA010101AAZ



8. Servicio REST JSON
===

Crea un archivo en app/views/report llamado <strong>receptor.json.jbuilder</strong>

<pre><code data-trim>
json.array!(@receipts) do |receipt|
  json.extract! receipt, 'emisor', 'receptor', 'total'
end
</code></pre>

http://localhost:3000/report/AAA010101AAZ.json



View Helpers
===

Los view helpers nos ayudan a modularizar el código de presentación.




Predefinidos
===

<pre><code data-trim>
#archivo app/views/report/receptor.html.erb
<h1>Comprobantes con el RFC receptor: <%= @rfc_receptor %></h1>

<table>
	<thead>
		<tr>
			<th>RFC Emisor</th>
			<th>RFC Receptor</th>
			<th>Total</th>
		</tr>
	</thead>
	<tbody>
<% @receipts.each do |receipt| %>
		<tr>
			<td><%= receipt['emisor'] %></td>
			<td><%= receipt['receptor'] %></td>
			<td><%= number_to_currency(receipt['total']) %>			
			</td>
		</tr>
<% end %>
	</tbody>
</table>
</code></pre>



Personalizados
===

Abre el archivo app/helpers/receipts_helper.rb

<pre><code data-trim>
module ReceiptsHelper
	def total( total )
		"$ #{total} MXN"
	end
end
</code></pre>



Reemplaza en receptor.html.erb
<pre><code data-trim>
<!--<td><%= number_to_currency(receipt['total']) %> -->
<td><%= total(receipt['total']) %>
</code></pre>



javascript
===

![Coffeescript](img/coffeescript_logo.jpg)



Agregar código al archivo de CS
===

<pre><code data-trim>
#archivo app/assets/javascripts/reports.js.coffee
$(document).ready ->
	$('td.total').hover (
		(ev) ->alert('El monto total es informativo')
		)
</code></pre>		

jQuery ya viene incluido.



Agrega una clase css al html y recarga la página
<pre><code data-trim>
<td class="total"><%= total(receipt['total']) %>
</code></pre>



Rails genera un archivo js al vuelo en modo development

![js](img/js_generado.jpg)



Assets pipeline para modo productivo
===

Detén tu servidor rails (Ctrl+c) y reinícialo en modo productivo
<pre><code data-trim>
rails server -e production
</code></pre>

Recarga la página: No existe el archivo js



El assets pipeline "precompila" los assets:

- Genera js a partir del archivo coffeescript.
- Genera CSS a partir de Sass.
- Minimiza y concatena js.
- Minimiza y concatena css.
- Agrega un fingerprint a los archivos.



Ejecuta
===

<pre><code data-trim>
rake assets:precompile
</code></pre>



Configuración
===

<pre><code data-trim>
#edita archivo config/environments/production	
config.serve_static_assets = true
</code></pre>