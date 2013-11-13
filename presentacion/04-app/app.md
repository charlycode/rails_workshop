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
</code></pre>



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
