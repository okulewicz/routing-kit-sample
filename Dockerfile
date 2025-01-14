FROM gcc:14.2.0

# Clone the RoutingKit repository
RUN git clone https://github.com/RoutingKit/RoutingKit.git /routing-kit/RoutingKit
RUN cd /routing-kit/RoutingKit && git checkout 078f5a2

# Build RoutingKit
WORKDIR /routing-kit/RoutingKit
RUN make
# Get data
WORKDIR /routing-kit
RUN wget https://download.geofabrik.de/europe/poland/mazowieckie-latest.osm.pbf > /routing-kit/file.pbf

# Copy the main.cpp file
COPY main.cpp .

# # Set up environment variables
ENV LD_LIBRARY_PATH=/routing-kit/RoutingKit/lib

#build the main.cpp file
RUN g++ -I /routing-kit/RoutingKit/include -L /routing-kit/RoutingKit/lib -std=c++11 /routing-kit/main.cpp -o /routing-kit/main -l routingkit

# Default command
CMD ["/bin/bash"]
