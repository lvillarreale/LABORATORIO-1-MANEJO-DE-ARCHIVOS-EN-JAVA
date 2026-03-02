import java.util.*;
import java.io.*;
import java.time.*;
import java.time.format.DateTimeFormatter;

ArrayList<Plato> listaPlatos = new ArrayList<Plato>();
ArrayList<Mesa> listaMesas = new ArrayList<Mesa>();
ArrayList<Pedido> listaPedidos = new ArrayList<Pedido>();

Scanner sc = new Scanner(System.in);

void setup() {
  size(600, 400);
  cargarPlatos();
  cargarMesas();
  cargarPedidos();
  menuPrincipal();
}

void draw() {}

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

void cargarPlatos() {
  listaPlatos.clear();
  File file = new File(dataPath("Platos.txt"));
  if (!file.exists()) return;

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

// ======================= MENU =======================

void menuPrincipal() {
  int opcion;
  do {
    println("\n--- MENU PRINCIPAL ---");
    println("1. CRUD Platos");
    println("2. CRUD Mesas");
    println("3. Crear Pedido");
    println("0. Salir");
    opcion = sc.nextInt();
    sc.nextLine();

    switch(opcion) {
    case 1:
      menuPlatos();
      break;
    case 2:
      menuMesas();
      break;
    case 3:
      crearPedido();
      break;
    }
  } while (opcion != 0);
}

// ======================= RF1 CRUD PLATOS =======================

void menuPlatos() {
  println("1. Crear Plato");
  println("2. Listar Platos");
  int op = sc.nextInt();
  sc.nextLine();

  if (op == 1) {
    println("ID:");
    String id = sc.nextLine();

    for (Plato p : listaPlatos) {
      if (p.id.equals(id)) {
        println("ID duplicado.");
        return;
      }
    }

    println("Nombre:");
    String nombre = sc.nextLine();
    println("Categoria:");
    String categoria = sc.nextLine();
    println("Precio:");
    double precio = sc.nextDouble();
    sc.nextLine();

    if (precio <= 0) {
      println("Precio inválido.");
      return;
    }

    listaPlatos.add(new Plato(id, nombre, categoria, precio, "SI"));
    guardarPlatos();
    println("Plato agregado.");
  }

  if (op == 2) {
    for (Plato p : listaPlatos) {
      println(p.id + " - " + p.nombre + " - $" + p.precio);
    }
  }
}

// ======================= RF2 CRUD MESAS =======================

void menuMesas() {
  println("1. Crear Mesa");
  println("2. Listar Mesas");
  int op = sc.nextInt();
  sc.nextLine();

  if (op == 1) {
    println("ID:");
    String id = sc.nextLine();

    for (Mesa m : listaMesas) {
      if (m.id.equals(id)) {
        println("ID duplicado.");
        return;
      }
    }

    println("Capacidad:");
    int capacidad = sc.nextInt();
    sc.nextLine();

    listaMesas.add(new Mesa(id, capacidad, "LIBRE"));
    guardarMesas();
    println("Mesa creada.");
  }

  if (op == 2) {
    for (Mesa m : listaMesas) {
      println(m.id + " - Cap: " + m.capacidad + " - " + m.estado);
    }
  }
}

// ======================= RF3 CREAR PEDIDO =======================

void crearPedido() {
  println("ID Pedido:");
  String idPedido = sc.nextLine();

  for (Pedido p : listaPedidos) {
    if (p.idPedido.equals(idPedido)) {
      println("ID Pedido duplicado.");
      return;
    }
  }

  println("ID Mesa:");
  String idMesa = sc.nextLine();

  boolean existeMesa = false;
  for (Mesa m : listaMesas) {
    if (m.id.equals(idMesa)) {
      existeMesa = true;
      m.estado = "OCUPADA";
    }
  }

  if (!existeMesa) {
    println("Mesa no existe.");
    return;
  }

  String fechaHora = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
  listaPedidos.add(new Pedido(idPedido, idMesa, fechaHora, "ABIERTO"));
  guardarPedidos();
  guardarMesas();

  println("Pedido creado correctamente.");
}
