import wx
from gps3 import gps3
import datetime
import math

class MyFrame(wx.Frame):
    def __init__(self):
        wx.Frame.__init__(self, None, title="Device Location", size=(400, 300))
        self.panel = wx.Panel(self)
        
        self.date_time_label = wx.StaticText(self.panel, label="Date/Time:", pos=(20, 20))
        self.latitude_label = wx.StaticText(self.panel, label="Latitude:", pos=(20, 50))
        self.longitude_label = wx.StaticText(self.panel, label="Longitude:", pos=(20, 80))
        self.speed_label = wx.StaticText(self.panel, label="Speed (Kph):", pos=(20, 110))
        self.location_label = wx.StaticText(self.panel, label="Location:", pos=(20, 140))
        
        self.date_time_text = wx.StaticText(self.panel, label="", pos=(120, 20))
        self.latitude_text = wx.StaticText(self.panel, label="", pos=(120, 50))
        self.longitude_text = wx.StaticText(self.panel, label="", pos=(120, 80))
        self.speed_text = wx.StaticText(self.panel, label="", pos=(120, 110))
        self.location_text = wx.StaticText(self.panel, label="", pos=(120, 140))
        
        self.update_data()
    
    def update_data(self):
        gps_socket = gps3.GPSDSocket()
        data_stream = gps3.DataStream()
        
        gps_socket.connect()
        gps_socket.watch()
        
        for new_data in gps_socket:
            if new_data:
                data_stream.unpack(new_data)
                if data_stream.TPV['lat'] and data_stream.TPV['lon']:
                    latitude = data_stream.TPV['lat']
                    longitude = data_stream.TPV['lon']
                    
                    current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    self.date_time_text.SetLabel(current_time)
                    self.latitude_text.SetLabel(str(latitude))
                    self.longitude_text.SetLabel(str(longitude))
                    
                    if self.previous_latitude is not None and self.previous_longitude is not None:
                        distance = self.calculate_distance(latitude, longitude, self.previous_latitude, self.previous_longitude)
                        speed = self.calculate_speed(distance)
                        self.speed_text.SetLabel(str(speed))
                    
                    self.location_text.SetLabel("")
                    
                    self.previous_latitude = latitude
                    self.previous_longitude = longitude
        
        wx.CallLater(1000, self.update_data)  # Update every 1 second
    
    def calculate_distance(self, lat1, lon1, lat2, lon2):
        # Calculate the distance between two coordinates using the haversine formula
        R = 6371  # Earth radius in kilometers
        
        dlat = math.radians(lat2 - lat1)
        dlon = math.radians(lon2 - lon1)
        
        a = math.sin(dlat/2) * math.sin(dlat/2) + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlon/2) * math.sin(dlon/2)
        c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
        
        distance = R * c
        return distance
    
    def calculate_speed(self, distance):
        # Calculate speed assuming time interval of 1 second
        speed = distance * 3600  # Convert distance from km/s to km/h
        return speed

app = wx.App()
frame = MyFrame()
frame.Show()
app.MainLoop()
