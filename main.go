package main

import (
	"log"
	
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/template/pug"
)

func tmtLen(value string) int {
	return len(value)
}

func main() {
	engine := pug.New("./views", ".pug")
	engine.AddFunc("len", tmtLen)

	app := fiber.New(fiber.Config{
		Views: engine,
		Prefork: true,
	})

	app.Static("/static", "./static")

	app.Get("/", func(c *fiber.Ctx) error {
		// Render index
		return c.Render("index", fiber.Map{
			"title": "Web Design",
			"email": "2yx2rx6uu@relay.firefox.com",
			"discord": "AliChraghi#8615",
		})
	})

	log.Fatal(app.Listen(":80"))
}