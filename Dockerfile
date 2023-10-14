# Selecciona la imagen base de Ruby
FROM ruby:3.1.2 AS builder

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos de la aplicación a la imagen
COPY . /app

# Instala las dependencias de la aplicación
RUN bundle install

# Comando para ejecutar la aplicación
CMD ["rails", "server", "-b", "0.0.0.0"]
