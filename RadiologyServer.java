import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.InetAddress;
import java.util.*;
import java.awt.*;
import java.awt.event.*;
import java.io.IOException;
import java.util.*;
import java.lang.reflect.Field;

public class RadiologyServer {
    private static final int PORT = 80;
    private static final String HOST = "192.168.1.145";
	private static Robot robot;
	private static int screen_width;
	private static int screen_height;
	
    public static void main(String[] args) throws AWTException,IOException {
		robot = new Robot();
		
		GraphicsDevice gd = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice();
		screen_width = gd.getDisplayMode().getWidth();
		screen_height = gd.getDisplayMode().getHeight();
	
        System.out.println("Starting HttpServer on port "+PORT);
        try{
            InetSocketAddress address = new InetSocketAddress(HOST, PORT);
            HttpServer httpServer = HttpServer.create(address, 0);
            System.out.println("Running..");
            HttpHandler handler = new HttpHandler() {
                public void handle(HttpExchange exchange) throws IOException {
					String uri = exchange.getRequestURI().toString();
					uri = uri.substring(1);
					Map<String, String> queryMap = getQueryMap(uri);
					
					if (queryMap.get("input").equals("keyboard")){
						keyboard(queryMap.get("keycodes"));
					} else if (queryMap.get("input").equals("mouse")) {
						if (queryMap.get("event").equals("move")) {
							mouseMove(queryMap);
						} else if (queryMap.get("event").equals("scroll")) {
							// try 100 and adjust from there
							mouseScroll(Integer.parseInt(queryMap.get("scroll")));
						} else if (queryMap.get("event").equals("click")) {
							robot.mousePress(InputEvent.BUTTON1_MASK);
							robot.mouseRelease(InputEvent.BUTTON1_MASK);
						} else if (queryMap.get("event").equals("right_click")) {
							robot.mousePress(InputEvent.BUTTON3_MASK);
							robot.mouseRelease(InputEvent.BUTTON3_MASK);
						} else if (queryMap.get("event").equals("middle_click")) {
						    robot.mousePress(InputEvent.BUTTON2_MASK);
						    robot.mouseRelease(InputEvent.BUTTON2_MASK);
						} else if  (queryMap.get("event").equals("left_down")) {
							// hold left mouse button down
							robot.mousePress(InputEvent.BUTTON1_MASK);
						} else if  (queryMap.get("event").equals("left_up")) {
							// release left mouse button
							robot.mouseRelease(InputEvent.BUTTON1_MASK);
						} else if  (queryMap.get("event").equals("middle_down")) {
						    // hold left mouse button down                                       
						    robot.mousePress(InputEvent.BUTTON2_MASK);
						} else if  (queryMap.get("event").equals("middle_up")) {
						    // release left mouse button                                         
						    robot.mouseRelease(InputEvent.BUTTON2_MASK);
						} else if (queryMap.get("event").equals("up,key")) {
						    // release left mouse button                                         
						    robot.mouseRelease(InputEvent.BUTTON1_MASK);
						    robot.delay(10);
						    keyboard(queryMap.get("keycode"));
                                                } else if (queryMap.get("event").equals("up,key,down")) {
						    robot.mouseRelease(InputEvent.BUTTON1_MASK);
						    robot.delay(10);
						    keyboard(queryMap.get("keycode"));
						    robot.mousePress(InputEvent.BUTTON1_MASK);
						}		       
					}
					
                    String response = "1";
                    byte[] bytes = response.getBytes();
                    exchange.sendResponseHeaders(HttpURLConnection.HTTP_OK,bytes.length);
                    exchange.getResponseBody().write(bytes);
                    exchange.close();
                }
            };
            httpServer.createContext("/", handler);
            httpServer.start();
            System.out.println("Press any key to stop.");
            System.in.read();
            httpServer.stop(0);
        }catch (Exception ex){
            System.out.println("Error: "+ ex.getMessage());
        }
        System.out.println("Stopped.");
    }
	
	public static Map<String, String> getQueryMap(String query)  
	{  
		String[] params = query.split("&");
		Map<String, String> map = new HashMap<String, String>();
		for (String param : params)
		{
			String name = param.split("=")[0];
			String value = param.split("=")[1];
			map.put(name, value);
		}
		return map;
	}
	
	public static void keyboard(String keycodes) {
		String[] tmp_arr = keycodes.split(",");
		for (int i = 0; i < tmp_arr.length; i++) {
			int keycode = Integer.parseInt(tmp_arr[i]);
			robot.delay(10);
			robot.keyPress(keycode);
		}
		robot.delay(20);
		for (int i = 0; i < tmp_arr.length; i++) {
		    int keycode = Integer.parseInt(tmp_arr[i]);
		    robot.delay(5);
		    robot.keyRelease(keycode);
                }

	}
	
	public static void mouseMove(Map<String, String> queryMap) {
		int x_step = Integer.parseInt(queryMap.get("x-step"));
		int y_step = Integer.parseInt(queryMap.get("y-step"));
		int num_steps = Integer.parseInt(queryMap.get("num-steps"));
		int delay = Integer.parseInt(queryMap.get("delay"));
		
		PointerInfo a = MouseInfo.getPointerInfo();
		Point b = a.getLocation();
		int x = (int) b.getX();
		int y = (int) b.getY();
		
		for (int i = 1; i <= num_steps; i++) {
			int new_x = x + i * x_step;
			int new_y = y + i * y_step;
			
			if (new_x < 0) {
				new_x = 0;
			} else if (new_x > screen_width - 1) {
				new_x = screen_width - 1;
			}
			
			if (new_y < 0) {
				new_y = 0;
			} else if (new_y > screen_height - 1) {
				new_y = screen_height - 1;
			}
			
			robot.mouseMove(new_x, new_y);
			robot.delay(delay);
		}
	}
	
	public static void mouseScroll(int movement) {
		// try around 100 for movement
		robot.mouseWheel(movement);
	}
}
