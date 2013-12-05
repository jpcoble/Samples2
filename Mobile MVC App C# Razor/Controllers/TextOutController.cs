using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MobileComm.Models;

namespace MobileComm.Controllers
{
    [Authorize(Roles = "SuperUser")]

    public class TextOutController : Controller
    {
        private DB_9ABA01_voicetextEntities db = new DB_9ABA01_voicetextEntities();



        //
        // GET: /TextOut/

        public ActionResult Index()
        {
            return View(db.TextOuts.ToList());
        }

        //
        // GET: /TextOut/Details/5

        public ActionResult Details(int id = 0)
        {
            TextOut textout = db.TextOuts.Find(id);
            if (textout == null)
            {
                return HttpNotFound();
            }
            return View(textout);
        }

        //
        // GET: /TextOut/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /TextOut/Create

        [HttpPost]
        public ActionResult Create(TextOut textout)
        {
            if (ModelState.IsValid)
            {
                db.TextOuts.Add(textout);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(textout);
        }

        //
        // GET: /TextOut/Edit/5

        public ActionResult Edit(int id = 0)
        {
            TextOut textout = db.TextOuts.Find(id);
            if (textout == null)
            {
                return HttpNotFound();
            }
            return View(textout);
        }

        //
        // POST: /TextOut/Edit/5

        [HttpPost]
        public ActionResult Edit(TextOut textout)
        {
            if (ModelState.IsValid)
            {
                db.Entry(textout).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(textout);
        }

        //
        // GET: /TextOut/Delete/5

        public ActionResult Delete(int id = 0)
        {
            TextOut textout = db.TextOuts.Find(id);
            if (textout == null)
            {
                return HttpNotFound();
            }
            return View(textout);
        }

        //
        // POST: /TextOut/Delete/5

        [HttpPost, ActionName("Delete")]
        public ActionResult DeleteConfirmed(int id)
        {
            TextOut textout = db.TextOuts.Find(id);
            db.TextOuts.Remove(textout);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}