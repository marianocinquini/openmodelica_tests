within ByD_D1.PC_Acc_Env;

model Env_variable_temp_humid_air_dens
  parameter Modelica.Units.NonSI.Temperature_degC temperature_param = 25 "Ambient temperature";
  parameter Modelica.Units.SI.Pressure pressure_param = 101325 "Ambient pressure";
  parameter Real humidity_param(unit = "1/100") = 50 "Ambient humidity";
  parameter Boolean varying_temp = false "Stablish if there will be a time-dependent temperature";
  parameter String temp_vs_time_fname = "temperature.mat" "Name of file containing temperature evolution vs time";
  parameter String temp_vs_time_tabname = "Temp" "Name of table containing temperature evolution vs time";
  parameter Boolean varying_humid = false "Stablish if there will be a time-dependent humidity";
  parameter String humid_vs_time_fname = "humidity.mat" "Name of file containing humidity evolution vs time";
  parameter String humid_vs_time_tabname = "Humid" "Name of table containing humidity evolution vs time";
  parameter Modelica.Units.SI.Acceleration gravity_param = 9.81 "Gravitational acceleration";
  
  Modelica.Blocks.Interfaces.RealOutput temperature(unit = "degC") annotation(
    Placement(visible = true, transformation(origin = {110, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-84, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput humidity(unit = "1/100") annotation(
    Placement(visible = true, transformation(origin = {110, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-44, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput pressure(unit = "Pa") annotation(
    Placement(visible = true, transformation(origin = {110, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {86, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput gravity(unit = "m/s2") annotation(
    Placement(visible = true, transformation(origin = {110, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {42, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealOutput air_dens(unit = "kg/m3") annotation(
    Placement(visible = true, transformation(origin = {110, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -110}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant Temp(k = temperature_param) annotation(
    Placement(visible = true, transformation(origin = {-64, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Press(k = pressure_param) annotation(
    Placement(visible = true, transformation(origin = {-8, -4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Humid(k = humidity_param) annotation(
    Placement(visible = true, transformation(origin = {-64, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T1(fileName = temp_vs_time_fname, tableName = "Temp", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-64, 84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.CombiTimeTable T2(fileName = humid_vs_time_fname, tableName = "Humid", tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-64, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch SW1 annotation(
    Placement(visible = true, transformation(origin = {16, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Logical.Switch SW2 annotation(
    Placement(visible = true, transformation(origin = {10, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression BE1(y = varying_temp) annotation(
    Placement(visible = true, transformation(origin = {-26, 76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.BooleanExpression BE2(y = varying_humid) annotation(
    Placement(visible = true, transformation(origin = {-28, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Air_density_calc air_density_calc annotation(
    Placement(visible = true, transformation(origin = {56, -84}, extent = {{-14, -14}, {14, 14}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant Grav(k = gravity_param) annotation(
    Placement(visible = true, transformation(origin = {-8, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(T1.y[1], SW1.u1) annotation(
    Line(points = {{-53, 84}, {4, 84}}, color = {0, 0, 127}));
  connect(Temp.y, SW1.u3) annotation(
    Line(points = {{-53, 58}, {-24.5, 58}, {-24.5, 68}, {4, 68}}, color = {0, 0, 127}));
  connect(BE1.y, SW1.u2) annotation(
    Line(points = {{-15, 76}, {4, 76}}, color = {255, 0, 255}));
  connect(BE2.y, SW2.u2) annotation(
    Line(points = {{-17, 36}, {-2, 36}}, color = {255, 0, 255}));
  connect(T2.y[1], SW2.u1) annotation(
    Line(points = {{-53, 20}, {-45.5, 20}, {-45.5, 44}, {-2, 44}}, color = {0, 0, 127}));
  connect(Humid.y, SW2.u3) annotation(
    Line(points = {{-53, -6}, {-44, -6}, {-44, 28}, {-2, 28}}, color = {0, 0, 127}));
  connect(SW1.y, temperature) annotation(
    Line(points = {{27, 76}, {110, 76}}, color = {0, 0, 127}));
  connect(SW2.y, humidity) annotation(
    Line(points = {{21, 36}, {110, 36}}, color = {0, 0, 127}));
  connect(Press.y, pressure) annotation(
    Line(points = {{3, -4}, {110, -4}}, color = {0, 0, 127}));
  connect(air_density_calc.Air_dens, air_dens) annotation(
    Line(points = {{71.4, -84}, {109.4, -84}}, color = {0, 0, 127}));
  connect(SW1.y, air_density_calc.Temp) annotation(
    Line(points = {{27, 76}, {31, 76}, {31, -76}, {39, -76}}, color = {0, 0, 127}));
  connect(SW2.y, air_density_calc.Humid) annotation(
    Line(points = {{21, 36}, {23, 36}, {23, -92}, {39, -92}}, color = {0, 0, 127}));
  connect(Press.y, air_density_calc.Press) annotation(
    Line(points = {{3, -4}, {17, -4}, {17, -84}, {39, -84}}, color = {0, 0, 127}));
  connect(Grav.y, gravity) annotation(
    Line(points = {{3, -44}, {110, -44}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0")),
    Diagram(graphics = {Polygon(origin = {-25, 70}, fillColor = {14, 188, 127}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-55, 30}, {55, 30}, {55, -18}, {-19, -18}, {-29, -30}, {-55, -30}, {-55, 30}, {-55, 30}}), Text(origin = {-20, 94}, extent = {{-18, 4}, {18, -4}}, textString = "Temperature = f(time)", fontName = "Space Grotesk Medium"), Polygon(origin = {-25, 14}, fillColor = {14, 188, 127}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, points = {{-55, 22}, {-29, 22}, {-15, 36}, {55, 36}, {55, 0}, {-9, 0}, {-9, -36}, {-55, -36}, {-55, 22}, {-55, 22}}), Text(origin = {-20, 94}, extent = {{-18, 4}, {18, -4}}, textString = "Temperature = f(time)", fontName = "Space Grotesk Medium"), Text(origin = {-14, 20}, extent = {{-18, 4}, {18, -4}}, textString = "Rel. Humidity = f(time)", fontName = "Space Grotesk Medium")}));
end Env_variable_temp_humid_air_dens;