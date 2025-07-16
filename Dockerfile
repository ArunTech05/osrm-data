FROM osrm/osrm-backend

# Install dependencies
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y wget

# Download smaller Chennai map from alternative source
RUN wget https://github.com/your-username/osrm-data/raw/main/chennai-latest.osm.pbf

# Process the map
RUN osrm-extract -p /opt/car.lua chennai-latest.osm.pbf
RUN osrm-partition chennai-latest.osm.pbf
RUN osrm-customize chennai-latest.osm.pbf
CMD ["osrm-routed", "--algorithm", "mld", "chennai-latest.osm.pbf"]
