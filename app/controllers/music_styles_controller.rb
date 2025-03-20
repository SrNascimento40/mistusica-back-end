class MusicStylesController < ApplicationController
    def generate
        styles = MusicStyle.order("RANDOM()").limit(2)
        
        if styles.size < 2
            render json: { error: "Não há estilos musicais suficientes no banco" }, status: :unprocessable_entity
        else
            render json: { styles: styles.map(&:name) }
        end
    end
end
  