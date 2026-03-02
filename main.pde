import java.util.*;
import java.io.*;
import java.time.*;
import java.time.format.DateTimeFormatter;
import javax.swing.JOptionPane;

ArrayList<Plato> listaPlatos = new ArrayList<Plato>();
ArrayList<Mesa> listaMesas = new ArrayList<Mesa>();
ArrayList<Pedido> listaPedidos = new ArrayList<Pedido>();


int pantalla = 0; // 0=principal,1=platos,2=mesas,3=pedido

void setup() {
  size(600, 400);
  cargarPlatos();
  cargarMesas();
  cargarPedidos();
  pantalla = 0;
}

void draw() {
  background(240);
  switch(pantalla) {
    case 0:
      drawMenuPrincipal();
      break;
    case 1:
      drawMenuPlatos();
      break;
    case 2:
      drawMenuMesas();
      break;
    case 3:
      crearPedido();
      pantalla = 0;
      break;
  }
}

void mousePressed() {
  if (pantalla == 0) {
    if (mouseX > 150 && mouseX < 450) {
      if (mouseY > 100 && mouseY < 140) pantalla = 1;
      else if (mouseY > 160 && mouseY < 200) pantalla = 2;
      else if (mouseY > 220 && mouseY < 260) pantalla = 3;
      else if (mouseY > 280 && mouseY < 320) exit();
    }
  } else if (pantalla == 1) {
    // en menú de platos: opciones 1 y 2 y volver
    if (mouseX > 150 && mouseX < 450) {
      if (mouseY > 100 && mouseY < 140) crearPlatoDialog();
      else if (mouseY > 160 && mouseY < 200) listarPlatosDialog();
      else if (mouseY > 220 && mouseY < 260) pantalla = 0; // volver
    }
  } else if (pantalla == 2) {
    // en menú de mesas
    if (mouseX > 150 && mouseX < 450) {
      if (mouseY > 100 && mouseY < 140) crearMesaDialog();
      else if (mouseY > 160 && mouseY < 200) listarMesasDialog();
      else if (mouseY > 220 && mouseY < 260) pantalla = 0; // volver
    }
  }
}

// dibuja un botón sencillo con texto centrado
void drawButton(float x, float y, float w, float h, String txt) {
  fill(200);
  rect(x, y, w, h);
  fill(0);
  textAlign(CENTER, CENTER);
  text(txt, x + w/2, y + h/2);
}

void drawMenuPrincipal() {
  textSize(24);
  fill(0);
  textAlign(CENTER);
  text("Menú Principal", width/2, 60);
  drawButton(150, 100, 300, 40, "1. Platos");
  drawButton(150, 160, 300, 40, "2. Mesas");
  drawButton(150, 220, 300, 40, "3. Crear Pedido");
  drawButton(150, 280, 300, 40, "0. Salir");
}

void drawMenuPlatos() {
  textSize(24);
  fill(0);
  textAlign(CENTER);
  text("CRUD Platos", width/2, 60);
  drawButton(150, 100, 300, 40, "1. Crear Plato");
  drawButton(150, 160, 300, 40, "2. Listar Platos");
  drawButton(150, 220, 300, 40, "<- Volver");
}

void drawMenuMesas() {
  textSize(24);
  fill(0);
  textAlign(CENTER);
  text("CRUD Mesas", width/2, 60);
  drawButton(150, 100, 300, 40, "1. Crear Mesa");
  drawButton(150, 160, 300, 40, "2. Listar Mesas");
  drawButton(150, 220, 300, 40, "<- Volver");
}

// ======================= MODELOS =======================

class Plato {
  String id;
  String nombre;
  String categoria;
  double precio;
  String disponible;

  Plato(String id, String nombre, String categoria, double precio, String disponible) {
    this.id = id;
    this.nombre = nombre;
    this.categoria = categoria;
    this.precio = precio;
    this.disponible = disponible;
  }

  String toFile() {
    return id + ";" + nombre + ";" + categoria + ";" + precio + ";" + disponible;
  }
}

class Mesa {
  String id;
  int capacidad;
  String estado;

  Mesa(String id, int capacidad, String estado) {
    this.id = id;
    this.capacidad = capacidad;
    this.estado = estado;
  }

  String toFile() {
    return id + ";" + capacidad + ";" + estado;
  }
}

class Pedido {
  String idPedido;
  String idMesa;
  String fechaHora;
  String estado;

  Pedido(String idPedido, String idMesa, String fechaHora, String estado) {
    this.idPedido = idPedido;
    this.idMesa = idMesa;
    this.fechaHora = fechaHora;
    this.estado = estado;
  }

  String toFile() {
    return idPedido + ";" + idMesa + ";" + fechaHora + ";" + estado;
  }
}

// ======================= CARGA DE ARCHIVOS =======================
// aquí el programa lee los archivos que usan en la compu, bien "manual" y simple

void cargarPlatos() {
  listaPlatos.clear(); // empezamos limpio
  File file = new File(dataPath("Platos.txt"));
  if (!file.exists()) return; // si no hay archivo no pasa nada

  String[] lineas = loadStrings("Platos.txt");
  for (String linea : lineas) {
    String[] datos = split(linea, ';');
    if (datos.length == 5) {
      listaPlatos.add(new Plato(datos[0], datos[1], datos[2], 
      Double.parseDouble(datos[3]), datos[4]));
    }
  }
}

void guardarPlatos() {
  String[] lineas = new String[listaPlatos.size()];
  for (int i = 0; i < listaPlatos.size(); i++) {
    lineas[i] = listaPlatos.get(i).toFile();
  }
  saveStrings("Platos.txt", lineas);
}

void cargarMesas() {
  listaMesas.clear();
  File file = new File(dataPath("Mesas.txt"));
  if (!file.exists()) return;

  String[] lineas = loadStrings("Mesas.txt");
  for (String linea : lineas) {
    String[] datos = split(linea, ';');
    if (datos.length == 3) {
      listaMesas.add(new Mesa(datos[0], Integer.parseInt(datos[1]), datos[2]));
    }
  }
}

void guardarMesas() {
  String[] lineas = new String[listaMesas.size()];
  for (int i = 0; i < listaMesas.size(); i++) {
    lineas[i] = listaMesas.get(i).toFile();
  }
  saveStrings("Mesas.txt", lineas);
}

void cargarPedidos() {
  listaPedidos.clear();
  File file = new File(dataPath("Pedidos.txt"));
  if (!file.exists()) return;

  String[] lineas = loadStrings("Pedidos.txt");
  for (String linea : lineas) {
    String[] datos = split(linea, ';');
    if (datos.length == 4) {
      listaPedidos.add(new Pedido(datos[0], datos[1], datos[2], datos[3]));
    }
  }
}

void guardarPedidos() {
  String[] lineas = new String[listaPedidos.size()];
  for (int i = 0; i < listaPedidos.size(); i++) {
    lineas[i] = listaPedidos.get(i).toFile();
  }
  saveStrings("Pedidos.txt", lineas);
}

// ======================= MENU (texto antiguo) =======================
// ya no usamos este menú principal porque ahora la interfaz se dibuja en pantalla

// ======================= RF1 CRUD PLATOS =======================

// el menú de texto original ya no se usa pero lo dejamos como referencia student code
void menuPlatos() {
  // esta era la versión sin interfaz gráfica
  println("1. Crear Plato");
  println("2. Listar Platos");
  int op = Integer.parseInt(JOptionPane.showInputDialog("1. Crear Plato\n2. Listar Platos"));
  if (op == 1) crearPlatoDialog();
  if (op == 2) listarPlatosDialog();
}

// nuevas funciones con diálogos muy básicos
void crearPlatoDialog() {
  String id = JOptionPane.showInputDialog("ID:");
  if (id == null) return;
  for (Plato p : listaPlatos) {
    if (p.id.equals(id)) {
      JOptionPane.showMessageDialog(null, "ID duplicado.");
      return;
    }
  }
  String nombre = JOptionPane.showInputDialog("Nombre:");
  if (nombre == null) return;
  String categoria = JOptionPane.showInputDialog("Categoria:");
  if (categoria == null) return;
  String precioStr = JOptionPane.showInputDialog("Precio:");
  if (precioStr == null) return;
  double precio = 0;
  try {
    precio = Double.parseDouble(precioStr);
  } catch (Exception e) {
    JOptionPane.showMessageDialog(null, "Precio inválido.");
    return;
  }
  if (precio <= 0) {
    JOptionPane.showMessageDialog(null, "Precio inválido.");
    return;
  }
  listaPlatos.add(new Plato(id, nombre, categoria, precio, "SI"));
  guardarPlatos();
  JOptionPane.showMessageDialog(null, "Plato agregado.");
}

void listarPlatosDialog() {
  if (listaPlatos.isEmpty()) {
    JOptionPane.showMessageDialog(null, "No hay platos registrados.");
    return;
  }
  StringBuilder sb = new StringBuilder();
  for (Plato p : listaPlatos) {
    sb.append(p.id).append(" - ").append(p.nombre).append(" - $").append(p.precio).append("\n");
  }
  JOptionPane.showMessageDialog(null, sb.toString());
}


// ======================= RF2 CRUD MESAS =======================

// versión de menú original (texto), ahora usa diálogo
void menuMesas() {
  int op = Integer.parseInt(JOptionPane.showInputDialog("1. Crear Mesa\n2. Listar Mesas"));
  if (op == 1) crearMesaDialog();
  if (op == 2) listarMesasDialog();
}

// nuevas funciones de diálogos para mesa
void crearMesaDialog() {
  String id = JOptionPane.showInputDialog("ID:");
  if (id == null) return;
  for (Mesa m : listaMesas) {
    if (m.id.equals(id)) {
      JOptionPane.showMessageDialog(null, "ID duplicado.");
      return;
    }
  }
  String capStr = JOptionPane.showInputDialog("Capacidad:");
  if (capStr == null) return;
  int capacidad = 0;
  try {
    capacidad = Integer.parseInt(capStr);
  } catch (Exception e) {
    JOptionPane.showMessageDialog(null, "Capacidad inválida.");
    return;
  }
  listaMesas.add(new Mesa(id, capacidad, "LIBRE"));
  guardarMesas();
  JOptionPane.showMessageDialog(null, "Mesa creada.");
}

void listarMesasDialog() {
  if (listaMesas.isEmpty()) {
    JOptionPane.showMessageDialog(null, "No hay mesas registradas.");
    return;
  }
  StringBuilder sb = new StringBuilder();
  for (Mesa m : listaMesas) {
    sb.append(m.id).append(" - Cap: ").append(m.capacidad).append(" - ").append(m.estado).append("\n");
  }
  JOptionPane.showMessageDialog(null, sb.toString());
}
// ======================= RF3 CREAR PEDIDO =======================

void crearPedido() {
  String idPedido = JOptionPane.showInputDialog("ID Pedido:");
  if (idPedido == null) return;

  for (Pedido p : listaPedidos) {
    if (p.idPedido.equals(idPedido)) {
      JOptionPane.showMessageDialog(null, "ID Pedido duplicado.");
      return;
    }
  }

  String idMesa = JOptionPane.showInputDialog("ID Mesa:");
  if (idMesa == null) return;

  boolean existeMesa = false;
  for (Mesa m : listaMesas) {
    if (m.id.equals(idMesa)) {
      existeMesa = true;
      m.estado = "OCUPADA";
    }
  }

  if (!existeMesa) {
    JOptionPane.showMessageDialog(null, "Mesa no existe.");
    return;
  }

  String fechaHora = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
  listaPedidos.add(new Pedido(idPedido, idMesa, fechaHora, "ABIERTO"));
  guardarPedidos();
  guardarMesas();

  JOptionPane.showMessageDialog(null, "Pedido creado correctamente.");
}
