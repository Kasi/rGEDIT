% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clipLevel1BGeo.R
\name{clipLevel1BGeoGeometry}
\alias{clipLevel1BGeoGeometry}
\title{Clip Level1BGeo data by geometry}
\usage{
clipLevel1BGeoGeometry(level1BGeo, polygon_spdf, split_by)
}
\arguments{
\item{level1BGeo}{A GEDI Level1b object (output of \code{\link[rGEDI:readLevel1B]{readLevel1B}} function). A S4 object of class "data.table".}

\item{polygon_spdf}{Polygon. An object of class \code{\link[sp]{SpatialPolygonsDataFrame-class}},
which can be loaded as an ESRI shapefile using \code{\link[raster:shapefile]{raster::shapefile()}} function in the \emph{raster} package.}

\item{split_by}{Polygon id. If defined, GEDI data will be clipped by each polygon using the polygon id from table of attribute defined by the user}
}
\value{
A S4 object of class \code{\link[data.table:data.table]{data.table-class}}.
}
\description{
This function clips GEDI level1B extracted geolocation (level1BGeo)
data within given geometry
}
\examples{
\dontrun{
# specify the path to download GEDI example dataset
outdir<-getwd()

# downloading GEDI example dataset (zip file)
download.file(
             paste0(
                    "https://github.com/carlos-alberto-silva/rGEDI/",
                    "releases/download/examples/examples.zip"
             ),
             destfile=paste0(outdir,"/examples.zip"))

# unzip the file
unzip(paste0(outdir,"\\\\examples.zip"))

# specify the path to GEDI level1B data
level1bpath = paste0(outdir,"\\\\GEDI01_B_2019108080338_O01964_T05337_02_003_01_sub.h5")

# Reading GEDI level1B file
level1b<-readLevel1b(gedilevel1b)

# Get GEDI level1B geolocations
level1BGeo<-getLevel1BGeo(level1b)

# specify the path to shapefile
polygon_filepath <- system.file("extdata", "stands_cerrado.shp", package="rGEDI")

# Reading shapefile as SpatialPolygonsDataFrame object
library(raster)
polygon_spdf<-shapefile(polygons_filepath)

level1bGeo_clip = clipLevel1BGeometry(level1bGeo, polygon_spdf, split_by="id")

library(leaflet)
leaflet() \%>\%
 addCircleMarkers(level1b_clip@dt$longitude_bin0,
                  level1b_clip@dt$latitude_bin0,
                  radius = 1,
                  opacity = 1,
                  color = "red")  \%>\%
 addScaleBar(options = list(imperial = FALSE)) \%>\%
 addPolygons(data=polygon_spdf,weight=1,col = 'white',
             opacity = 1, fillOpacity = 0) \%>\%
 addProviderTiles(providers$Esri.WorldImagery)
}
}
\seealso{
https://lpdaac.usgs.gov/products/gedi01_bv001/
}